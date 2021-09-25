R attrition project

DESCRIPTION
 
Due to challenging work environment & competition, the business may be constantly varying as sometimes it may be increasing or decreasing or may  be in a constant scale.so as a cost cutting feature the companies lay the workforce or else the workers resign based on several factors. 

There are many reasons for the employee to churn or not to churn in an organisation based on many factors like 'Age, Business Travel, Daily Rate, Department, Distance From Home, Education, Education Field, EmployeeNumber,etc. It’s necessary to inspect the reasons for the people to get laid. So, So this project inspects the reasons for the people to resign.




## Acknowledgements
Data Source:The dataset is available as attrition.csv. 
(URL: https://www.kaggle.com/pavansubhasht/ibm-hr-analytics-attrition-dataset)



  
Data contains differenet attributes of an employee and the target variable Atrition. EmployeeNumber is the primary key. We use this dataset to predict employee churn.

Data definitions for categorical variables: 

Education 1 'Below College' 2 'College' 3 'Bachelor' 4 'Master' 5 'Doctor'

EnvironmentSatisfaction 1 'Low' 2 'Medium' 3 'High' 4 'Very High'

JobInvolvement 1 'Low' 2 'Medium' 3 'High' 4 'Very High'

JobSatisfaction 1 'Low' 2 'Medium' 3 'High' 4 'Very High'

PerformanceRating 1 'Low' 2 'Good' 3 'Excellent' 4 'Outstanding'

RelationshipSatisfaction 1 'Low' 2 'Medium' 3 'High' 4 'Very High'

WorkLifeBalance 1 'Bad' 2 'Good' 3 'Better' 4 'Best'
  
## 🚀 About Me
I'm a Data Science Enthusiast  learning new technologies related to the analytics domain.
Intrested in providing solution to various problem statements.

  
## Appendix

Data contains different attributes of an employee and the target variable Atrition. EmployeeNumber is the primary key. We use this dataset to predict employee churn.

Data definitions for categorical variables: 

Education 1 'Below College' 2 'College' 3 'Bachelor' 4 'Master' 5 'Doctor'

EnvironmentSatisfaction 1 'Low' 2 'Medium' 3 'High' 4 'Very High'

JobInvolvement 1 'Low' 2 'Medium' 3 'High' 4 'Very High'

JobSatisfaction 1 'Low' 2 'Medium' 3 'High' 4 'Very High'

PerformanceRating 1 'Low' 2 'Good' 3 'Excellent' 4 'Outstanding'

RelationshipSatisfaction 1 'Low' 2 'Medium' 3 'High' 4 'Very High'

WorkLifeBalance 1 'Bad' 2 'Good' 3 'Better' 4 'Best'


  
## Documentation

[Documentation](https://linktodocumentation)

Step-1) Exploratory Data Analysis

1)Checking for na values using viss_miss- by looking at the raph we come to conclusion that the na values are not present.

2)Corelation matrix:The corelation among different variables are found using corelation matrix

3)The variables are  converted to their specific data type as follows:
Attrition data is converted to numeric data type from character
Business Travel, Department,Education Field, Gender, jobRole, Martial Status, Over 18, OverTare converted from character data type to numeric type in order to apply the logistic regression.

Note: The character data type variables are  converted to numeric data type only once they have been converted to factor variables.

Step-2) Model Building 
Prior to building the model we need to partition the master  data to train & test data by aquiring the row indices of the data.

Once the indices are aquired we split the data in the ratio 70:30 or 7:3 to create train as well as test data

Checking the multicollinearity  among the dependent  variables using vifstep function that caluclates the VIF value.

Note: The variables whose Varaible Inflation factor(VIF) is between 1 to 5 are choosen as significant in model building &  other variabes are discarded.

The Step AIC function is  used in the next step to progressively eliminate the variables having high collinearity until I have the least Alkaine information Criteria(AIC).

Suitable models are built using logistic regression algorithm until all the insignificant variables are eliminated.Out of 34 dependent variables only 17 variables were found to be signicant in model building

The suitable model is predicted on the test data & rounded to the nearest function using ifelse function.

Evaluation metrics  of Logistic Regression model are tabulated below:
Accuracy value of the model:87.85%
Sensitivity : 0.8884         
Specificity : 0.7727 

The Area under ROC curve is found to be 83.23%

MODEL USING DECISION TREE ALGORITHM USING GINI INDEX AS THE SPLITTING CRITERION:
Step-1) Exploratory Data Analysis(EDA) remains the same as in the previous model

Step-2) Model-Building
The rpart function is used to build the model using gini criterion with a maximum depth of the tree as 6.

On comparing the training data & testing data the accuracy of the model on training data as well as on the testing data were 89.60% & 84.58% respectively so it's mandatory to prune the tree using prune function to avoid overfitting.After pruning the decision tree to a desired Complexity parameter(C.P) of 0.01
the accuracy was around 84.58%.

MODEL USING DECISION TREE ALGORITHM USING Information gain as the splitting criterion
Using the information criterion as splitting criterion with complexity parameter as 0,
the evaluation metrics were tabulated as follows:

Accuracy : 0.8685 or 86.85%
Sensitivity : 0.9867
Specificity : 0.1719

On comparing the evaluation metrics the Logistic Regression model is preferred over the decision tree algorithm 







































## Tech Stack

**Client:** Imarticus Learning

This project was a capstone project where the R programming language was used.

  