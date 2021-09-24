'Logistic Regression'
#Current working directory
getwd()
setwd('C:\\Users\\anagha141\\Desktop\\Phyton Learning\\RProject-Attrition\\R Project - Attrition')
library(plyr)
library(corrplot)
library(ggplot2)
library(gridExtra)
install.packages('ggthemes')
install.packages('party')
library(ggthemes)
library(caret)
library(MASS)
library(party)
library(RColorBrewer)
library(ROCR)
library(class)
library(rpart)
install.packages('ratt')
library(rattle)
library(rpart.plot)
library(e1071)
library(data.table)
library(caTools)
#reading the data file
attrition_data=read.csv('Attrition.csv')
str(attrition_data)
  
#Visualising the na values
library(readr)
library(naniar)
vis_miss(attrition_data)

# We come to know there are no missing in the varaiables
#Finding the corelation matrix
library(corrplot)
numeric.var <- sapply(attrition_data, is.numeric)
corelation_matrix<-cor(attrition_data[,numeric.var])
corrplot(corelation_matrix,main='Corrplot')
#Data Visualization
library(ggplot2)
#graph showing relationships across numerical variables
cont_vars <- c("Age", "DailyRate","DistanceFromHome","HourlyRate","MonthlyIncome","MonthlyRate",
               "NumCompaniesWorked","PercentSalaryHike","TotalWorkingYears","TrainingTimesLastYear",
               "YearsAtCompany", "YearsInCurrentRole",  "YearsSinceLastPromotion","YearsWithCurrManager",
               "EmployeeCount")
melt_attrition_data = melt(attrition_data[,c("Attrition", cont_vars)], id.var = "Attrition")
p <- ggplot(data = melt_attrition_data , aes(x=variable, y=value)) + geom_boxplot(aes(fill= Attrition))
p <- p + facet_wrap( ~ variable, scales="free")
p

#OUTLIER DETECTION
i=1
for (i in attrition_data) {
  lower_bound <- quantile(attrition_data$i, 0.25)
  upper_bound <- quantile(attrition_data$i, 0.75)
  
  outlier_ind <- which(attrition_data$i < lower_bound | attrition_data$i > upper_bound)
  

}
attrition_data[outlier_ind,]
#to convert the target variable attrition to dichotomous variable

attrition_data$Attrition=ifelse(attrition_data$Attrition=='No',0,1)


#Conversion of target variable of factor type   to numerical  variable
attrition_data$Attrition<-as.numeric(attrition_data$Attrition)



#Conversion of Over 18 variable to numerical variable
attrition_data$Over18[attrition_data$Over18 =="Y"]=1

attrition_data$Over18=as.numeric(attrition_data$Over18)


table(attrition_data$BusinessTravel)
str(attrition_data$Attrition)
#Conversion of categorical variables to  numeric varaiables
str(attrition_data)
attrition_data[,c(3,5,8,12,16,18,23)]<-lapply(attrition_data[,c(3,5,8,12,16,18,23)],as.factor)

attrition_data[,c(3,5,8,12,16,18,23)]<-lapply(attrition_data[,c(3,5,8,12,16,18,23)],as.numeric)


str(attrition_data)

library(caret)

#Splitting the data
set.seed(1234)
createDataPartition(y= attrition_data$Attrition, p=0.7)
train.rows<- createDataPartition(y= attrition_data$Attrition, p=0.7, list = FALSE)
train.data<- attrition_data[train.rows,]

train.data
test.data<- attrition_data[-train.rows,]
test.data
# TO check if the dataset is correctly split
dim(train.data);dim(test.data)
1029/(1029+441)


library(usdm)
#CHecking the multi-Collinearity using the Vif function & eliminating the varibles that are less than 1.

vifstep(attrition_data[,-2],th=10)
class(attrition_data)

model1=glm(Attrition~Age+BusinessTravel+DailyRate+Department+ DistanceFromHome+Education+EducationField+EmployeeCount+EmployeeNumber+ EnvironmentSatisfaction+Gender+ HourlyRate +JobInvolvement+JobRole+JobSatisfaction+Gender+HourlyRate+
             JobInvolvement+JobRole+JobSatisfaction+MonthlyIncome+MonthlyRate+NumCompaniesWorked+Over18+OverTime+PercentSalaryHike+PerformanceRating+RelationshipSatisfaction+StandardHours+StockOptionLevel+TotalWorkingYears + TrainingTimesLastYear+ WorkLifeBalance+YearsAtCompany+YearsInCurrentRole+YearsSinceLastPromotion+YearsWithCurrManager,family = 'binomial',data=train.data)
summary(model1)


library(MASS)
stepAIC(model1,direction='both')

model2= glm(formula = Attrition ~ Age + Department + DistanceFromHome + 
              EnvironmentSatisfaction + Gender + JobInvolvement + JobSatisfaction + 
              MonthlyIncome + NumCompaniesWorked + OverTime + RelationshipSatisfaction + 
              StockOptionLevel + TotalWorkingYears + TrainingTimesLastYear + 
              WorkLifeBalance + YearsAtCompany + YearsInCurrentRole + YearsSinceLastPromotion + 
              YearsWithCurrManager, family = "binomial", data = train.data)



summary(model2)
#Removing the insignificant variables
model3=update(model2,.~.-Gender-YearsAtCompany,data=train.data)

summary(model3)

#Prediction of model on the test data
prediction_1=predict(model1,type='response',data=test.data)

prediction_1
#Setting the Threshold & Mapping the values to 0 & 1
predict_1=ifelse(prediction_1<0.5,0,1)

predict_1

library(caret)
#Creation of confusion matrix & checking the accuracy on test data

metrics<-confusionMatrix(table(train.data$Attrition,predict_1))



metrics


sensitivity(table(actuals = train.data$Attrition,predictedScores = predict_1))
R2(pred=predict_1,obs = train.data$Attrition)
#ON creation of confusion matrix we get a accuracy of 87.85%,sensitivity=0.8884,specificity=0.7727,kappa value=45.98.



length(predict_1)
library(InformationValue)
#ROC CURVE
plotROC(actuals=train.data$Attrition,predictedScores=as.numeric(fitted(model3)))




#we can perform the Hoshmer-Lemeshow goodness of fit test on the data set, to judge the accuracy of the predicted probability of the model.
#The hypothesis is: #H0: The model is a good fit.
#H1: The model is not a good fit.
#If, p-value>0.05 we will accept H0 and reject H1.
library(MKclass)
HLgof.test(fit=model3$fitted.values,obs=model3$y)
library(caret)
abc<-data.frame(RMSE=RMSE(pred = predict_1,obs = test.data$Attrition,na.rm = TRUE))
abc



#As the p-value is 0.1418 which is greater than 0.05 we accept the null hypothesis & we can conclude the built model is a food fit
................#Decision Tree#....................


getwd()

setwd('C:\\Users\\anagha141\\Desktop\\Phyton Learning\\RProject-Attrition\\R Project - Attrition')
attrition_data=read.csv('Attrition.csv')

#Using the gini index as the splitting criterion we build the model
model_1=rpart(Attrition~.,data = train.data,method='class',control=list(maxdepth=6))
model_1
#to confirm whether splitting is correct
dim(train.data);dim(test.data)


fancyRpartPlot(model_1)
printcp(model_1)
plotcp(model_1)


pred_training <-predict(model_1,train.data,type = "class")


pred_testing<-predict(model_1,test.data,type="class")


con_matrix<-table(pred_training,train.data$Attrition)

sum(diag(con_matrix)/sum(con_matrix))


con_matrix_test<-table(pred_testing,test.data$Attrition)
sum(diag(con_matrix_test))/sum(con_matrix_test)
# On checking the accuracy on the train & test data we com to know that the there is a overfit.
#Hence we prunethe tree
#Pruning the Tree
pruned <- prune(model_1, cp = 0.01)

printcp(pruned)

pred_pruned=predict(pruned, test.data, type = "class")
conf_i <- table(test.data$Attrition, pred_pruned)
conf_i

sum( diag(conf_i) ) / sum(conf_i)

# Change the first line of code to use information gain as splitting criterion
model_i <- rpart(Attrition ~ ., train.data, method = "class",
                 parms = list(split = "information"),control = 
                   rpart.control(cp = 0, maxdepth = 6,minsplit = 100))


printcp(model_i)

plotcp(model_i)
fancyRpartPlot(model_i)
pred_i <-predict(model_i, test.data, type = "class")
pred_i


conf_pred_i<-table(test.data$Attrition,pred_i)

sum(diag(conf_pred_i)/sum(conf_pred_i))
confusionMatrix(table(pred_i,test.data$Attrition))

  R2=R2(pred =as.numeric(pred_i),obs = test.data$Attrition,na.rm = TRUE)
RMSE=RMSE(pred=as.numeric(pred_i),obs=test.data$Attrition,na.rm=TRUE )
RMSE
# We have got an accuracy of 84.81%, Sensitivity of 98.11%, Specicity of 14.29% & kappa value 0.179


#AS the accuracy of logistic regression is greater than decision tree we come to conclusion that the logistic regression is preferable algorithm for the attrition dataset.


