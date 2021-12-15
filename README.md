# Module 7 Challenge

## Silver Tsunami

### Background
During this Module we covered SQL language program so we could filter and organize data in new tables from the Pewlett Hackard Company. As some employees, who were born between 1952 and 1955 begin to retire at a rapid rate, Pewlett Hackard wanted to address them and they were very interested in the positions that will be needed to fill in the near future.
In other hand, the Sales and Development Department want to introduce a mentoring program in which successful and experienced employees will mentor the new incorporations, instead of having a large amount of employees and knowledge retiring completely.

### Overview of the analysis
Bobby’s manager called this project: “silver tsunami” as many current employees reach retirement age.
In this challenge, we want to **determine the number of retiring employees per title**, and **identify employees who are eligible to participate in a mentorship program**.

## Results
Provide a bulleted list with four major points from the two analysis deliverables. Use images as support where needed.
There is a bulleted list with four major points from the two analysis deliverables.

- While making the Table that contains the amount of retiring employees per title, we noticed that some of them have one or more titles -- may due promotions.

![D1S1_InspoDistPromotions](https://user-images.githubusercontent.com/90414330/144700512-15d3558a-d7c9-4519-99db-a4b7528b59a0.png)
 
- In the table `retiring_titles`, we selected the last title found in for each employee and count them using the `GROUP BY` function. 

![NREBT_P1](https://user-images.githubusercontent.com/90414330/144699763-facd63f7-a10d-44ce-bd18-287c009e2c7c.png)

> We notice that the most important titles to replace are Senior Engineers and Staff. 


- In the `mentorship elegibility` table, we have all the current employees from Pewlett Hackard borned in 1965 and all their titles.

![delivery2](https://user-images.githubusercontent.com/90414330/146100464-cf910342-7685-48b4-809d-c77dd7bed823.png)

- And finally, the distribution of the titles that will need mentors.

![mentorship_titles](https://user-images.githubusercontent.com/90414330/146101205-1a3d96ab-5f4e-4a95-90c8-8a0db2d1c098.png)

## Summary
- **The summary addresses the two questions and contains two additional queries or tables that may provide more insight.**
-  How many roles will need to be filled as the "silver tsunami" begins to make an impact?
	-  As the "silver tsunami" begins to make an impact, there will need to be filled 7 different roles, and 90,398 vacancies.
![NREBT_P1](https://user-images.githubusercontent.com/90414330/144699763-facd63f7-a10d-44ce-bd18-287c009e2c7c.png)

| ![titles_count](https://user-images.githubusercontent.com/90414330/145664566-79f08e03-9718-4419-980e-71ab765a6a66.png) | ![sum_emp_count0](https://user-images.githubusercontent.com/90414330/145664954-01602b25-776f-4206-ae36-6dd19e456e64.png) |
|--|--|
|  |  |

-   Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
	- In order to answer this question, it was necessary to make two tables inspired by the 'retiring_titles' from the Delivery 1 and add the last department_name in which the employees are working. This way, we could also see the departments in which there will be needed to fill titles, or mentors.

| `retiring_titles_dept` | `mentorship_titles_dept` |
|--|--|
| ![retiring_titles_tables_p1](https://user-images.githubusercontent.com/90414330/145692358-33f67023-6975-4f73-93d5-68a5d0a4e472.png) | ![mentorship_titles_dept_p1](https://user-images.githubusercontent.com/90414330/145692513-fbcbe4f2-71f5-4814-83f8-261628c02d9d.png)|
| ![retiring_titles_tables_p2](https://user-images.githubusercontent.com/90414330/145692359-d614e08e-cbb7-438f-b775-ce51f524dfbc.png) | ![mentorship_titles_dept_p2](https://user-images.githubusercontent.com/90414330/145692511-fadf2284-7a5a-450c-9756-4dddf1031453.png) |

> In the `*_titles_dept` table, we can see the number of *retiring
> employees* or *employees that are eligible for the mentorship program*
> per title, and department.

But it is somewhat difficult to answer if there are enough retirement-ready employees to mentor the next generation, for this reason, we are going to make a `LEFT JOIN` on the second table --`mentorship_titles_dept`-- :

![comparition_mentorshipNretiring_titlesNdept_p1](https://user-images.githubusercontent.com/90414330/146076809-7a5fda57-9227-4842-b336-91f84fcf4f35.png)
![comparition_mentorshipNretiring_titlesNdept_p2](https://user-images.githubusercontent.com/90414330/146076813-18cca272-133a-4202-9b2e-ea3e89b1ed82.png)

This way, we notice that it's easier to compare and to tell that **there are enough mentors for the next generation**. 

- There will be 30% of the titles vacant if the employees get retired completely. 

| ![Count Total Employees](https://user-images.githubusercontent.com/90414330/145354547-10ea478e-dcb7-456c-9697-df9e9964c90c.png) | ![Count Retiring Titles](https://user-images.githubusercontent.com/90414330/145354544-94b9eff7-fe64-4453-9c71-cc03761d7861.png)|
|--|--|
|  |  |

> Getting the total sum of the titles which will be vacant, and the count of the employees in the `employees` table we can calculate the percentage.

- Making the `retiring_titles` I found interesting to know the distribution for the promotions that the employees that will get retired got during their period in PHCompany.

![promotion_distribution_retiringemp](https://user-images.githubusercontent.com/90414330/146101512-5a3a95c4-a128-4b36-99a2-100b5d1b8394.png)

This way, we know that it's not common to grow in the company.
 
### Additional Notes

1. In the `unique_table` for the **Delivery 1**, if we add the `to_date` column, we can notice that some of the employees ready-for-retirement aren't still working in the company. ![D1S2_utwtodate](https://user-images.githubusercontent.com/90414330/145161299-6c22769e-c22b-4e2f-b4fe-a469095df5ba.png)


| Unique Table | Ex - Employees |
|--|--|
| Employees borned between 1952 and 1955 | Employees borned between 1952 and 1955, and whose last title has a `to_date` value different of '9999-01-01'|
|![Count Retiring Titles](https://user-images.githubusercontent.com/90414330/145161672-4cf18c35-9688-4211-82ee-9c8bbb20ff41.png)|![D1_CountExemployees](https://user-images.githubusercontent.com/90414330/145161670-79b64948-0ed7-47cd-96a8-c3a78a01534e.png)
|
Those ex-employees represent 20% of the data from the `unique_titles` table, if we delete them and re-do the `retiring_titles` table:
| `retiring_titles` | `current_retiring_titles` |
|--|--|
| Counts the last title found for each person borned between 1952 and 1956.| Counts the last title found for each **current employee** of *PHCo* borned between 1952 and 1956.|
|  ![NREBT_P1](https://user-images.githubusercontent.com/90414330/144699763-facd63f7-a10d-44ce-bd18-287c009e2c7c.png)![titles_count](https://user-images.githubusercontent.com/90414330/145664566-79f08e03-9718-4419-980e-71ab765a6a66.png) | ![current_retiring_titles](https://user-images.githubusercontent.com/90414330/145664739-7c3f4678-48c7-4966-a45d-18631401e82d.png)![count_current_retiring_titles](https://user-images.githubusercontent.com/90414330/145664797-b0a921c2-108a-48f9-a08b-d5241a97d181.png) |
|![sum_emp_count0](https://user-images.githubusercontent.com/90414330/145664954-01602b25-776f-4206-ae36-6dd19e456e64.png)|![sum_emp_count1](https://user-images.githubusercontent.com/90414330/145664952-eeba411e-a921-41be-9c7b-f97e5fa7d7da.png)|
We notice that the titles remain in the same order, but there are less employees ready for retirement in almost every category. Not a very  significant change, but something to keep in mind.





> Written with [StackEdit](https://stackedit.io/).
