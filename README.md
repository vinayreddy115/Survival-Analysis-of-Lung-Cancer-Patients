# Survival-Analysis-of-Lung-Cancer-Patients

Analyzed the Veteran's Administration Lung Cancer Trial, where 137 patients with advanced, inoperable lung cancer were treated with chemotherapy (standard treatment) vs chemotherapy combined with a new drug (test treatment).

## objective : 
To do survival analysis on Lung Cancer Trial data and present report for a medical audience (doctors). 

https://user-images.githubusercontent.com/54513205/106189955-f3d83480-6176-11eb-8a88-d33b1f1d4020.png

## Code and Resources Used

### R packages :
survminer,survival,ggsurvplot, stargazer
### Data Source : 
Veteran's Administration Lung Cancer Trial

#### a. What is the probability that the patient will survive for 1 year (365 days) and 6 months (183 days) on the standard treatment vs the test treatment?
•	For Standard treatment: the probability that the patient will survive for 1 year (365 days) and 6 months (183 days) on the standard treatment is around 0.06 and 0.21.
•	For test treatment: the probability that the patient will survive for 1 year (365 days) and 6 months (183 days) on the test treatment is around 0.10 and 0.22

So higher probability of surviving is for the test treatment, compared to the standard treatment.

  Survival	                Standard treatment	test treatment
P(survival = 183 days)	                  0.21	0.22
P(survival = 365 days)	                  0.06	0.10
Mean number of days	                  100 days	52 days

#### b. What is the mean number of days where a patient can be expected to survive if they are on the standard vs the test treatment.

•	Mean number of days for standard: around 100 days
•	Mean number of days for test: 52 days

![image](https://user-images.githubusercontent.com/54513205/106191458-e58b1800-6178-11eb-8a3d-ca57aed5b9ed.png)

### Model Building:

Parametric and semi-parametric models - For all the independent variables


### Exponential, Weibull, and log-logistic parametric model coefficients

#### 2. Create three semi-parametric and parametric models to estimate the marginal effects of relevant predictors on survival outcomes. Interpret the coefficients of these models to explain the precise effects of age and months of diagnosis on survival probabilities of patients with standard and test treatments.
#### Cox proportional hazard model - For all the independent variables

Cox <- coxph(Surv(Survival, Status) ~  as.factor(Treatment)+ as.factor(Cell_type)+ Age + Diagnosis_Time + Karnofsky_score + as.factor(Prior_chemotherapy), method="breslow")

#### Parametric and semi-parametric models - For all the independent variables

exp <- survreg(Surv(Survival, Status) ~ as.factor(Treatment)+as.factor(Cell_type)+ Age + Diagnosis_Time+Karnofsky_score +as.factor(Prior_chemotherapy), dist="exponential")

weibull <- survreg(Surv(Survival, Status) ~ as.factor(Treatment)+as.factor(Cell_type)+ Age + Diagnosis_Time+Karnofsky_score +as.factor(Prior_chemotherapy), dist="weibull")

loglogistic <- survreg(Surv(Survival, Status) ~ as.factor(Treatment)+as.factor(Cell_type)+ Age + Diagnosis_Time+Karnofsky_score +as.factor(Prior_chemotherapy), dist="loglogistic")


#### insights and Recommendations to Medical Audience: 

#### From Cox proportional hazard mode
*	As the coefficient 0.28 is positive, it implies the patients with Test treatment are more likely for the occurrence of event i.e. hazard rate. Also, the 1.33 indicates that, patients who undergo test treatment have a 33% higher chances of death compared to standard treatment.
* Age has negative effect on hazard rate, i.e. one unit increase in Age decreases the hazard rate by 0.8%, though p-value is not significant
•	Also, the diagnosis time has a negative effect on hazard rate, one unit increase of diagnosis time decreases the hazard rate by 0.93% which is negligible
•	If patients have prior Chemotheraoy, there is high chances of death, i.e. it increases by 7.5%
•	Patients with increasing karnofsky_score is likely to live more and with hazard rate decrease by 4%.  Healthy people live longer with cancer.
•	Cell types 2,3 and 4 have more impact on the hazard rate compared to type 1, having them inreases the possibility of death.

#### from Parametric and semi-parametric models
•	Treatment type: patients with treatment 2 are more likely prone to death compared to that of treatment 1. Patients with treatment2 , increases the possibility of event occurring(Hazard rate)
•	For exponential, Weibull, loglogistic models, the treatment type 2 has negative effect, which implies the survival rate of patients is less compared to that of treatment type 1
•	Cell type 2,3,4 has positive effect on the hazard rate, which indicated the people cell type1 has the higher chance of living.
•	Prior Chemotherapy- If a patient is treated early by chemotherapy, time to death is decreased by a factor of 0.05, (Exponential model),0.04 (Weibull model) 0.1 (Loglogistic model). 
•	Age has negative effect on hazard rate, 
•	Also, the diagnosis time has a negative effect on hazard rate, 


