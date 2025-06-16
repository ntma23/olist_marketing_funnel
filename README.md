# Olist Marketing and Sales Funnel Analysis

## **Project Background**

Olist, a Brazilian e-commerce department store in marketplaces, connects small businesses to channels with a single contract. Those merchants can sell their products through the Olist Store and ship them directly to the customers using Olist’s logistics partners. 

Insights and recommendations provided focus on Marketing Qualified Lead (MQL) volume, Closed Deals volume, Lead-to-Close ratio, and Median Time to close (to minimize outliers’ impact):

- MQL Trends
- Lead Sources Performance
- Business Types and Segments Performance

The SQL file used for checking and cleaning can be found [here](https://github.com/ntma23/olist_marketing_funnel/blob/main/olist_mkt_funnel_check.sql).

The SQL file used for preliminary exploratory analysis can be found [here](https://github.com/ntma23/olist_marketing_funnel/blob/main/olist_mkt_funnel_eda.sql).

An interactive Power BI dashboard can be downloaded [here](https://github.com/ntma23/olist_marketing_funnel/blob/main/marketing_funnel.pbix).

## **Data Structure**

Olist’s database structure consists of 2 tables: mql with 8K records and closed_deals with 842 rows. Only after closing the deal, further information about lead types and business features was collected. 
![image](https://github.com/user-attachments/assets/c0dbc871-2ccf-425f-8bbd-6177ff6c288b)


Prior to the analysis, several checks were performed to ensure familiarity with the dataset and maintain data hygiene, which included removing irrelevant columns. 

The SQL file used for checking and cleaning can be found [here](https://github.com/ntma23/olist_marketing_funnel/blob/main/olist_mkt_funnel_check.sql).

The Issue Log Excel file can be found [here](https://github.com/ntma23/olist_marketing_funnel/blob/main/Olist%20MQL%20Issue%20Log.xlsx).

## **Executive Summary**

The company experienced a dramatic transformation in early 2018, with median conversion times dropping from 2-13 months to just 18 days and a 470% month-over-month (MoM) increase in lead volume. While top lead sources (organic search, paid search, social media) generated over 50% of MQLs, social media significantly underperformed, whereas direct traffic achieved a high conversion rate in a short time despite low volume. Resellers dominated with 70% of closed deals, particularly in car accessories, while manufacturers focused on home decor, with both business types showing the fastest conversion time of under one week.

The following sections will provide more detailed insights for opportunities and improvements:

Below is the screen capture from the Power BI dashboard, and more examples are included throughout the report. The entire interactive dashboard can be accessed [here](https://github.com/ntma23/olist_marketing_funnel/blob/main/marketing_funnel.pbix). 

![image](https://github.com/user-attachments/assets/7b1c9732-75f5-46dc-9640-5244b3705916)




## **Insight Deep Dives**

### **MQL Trends Overview**

- In 2017, closed deals were **minimal** (peaking at just 18), and conversion times were **long**, ranging from nearly 2 to 13 months.
- However, early 2018 marked a **dramatic shift**: median conversion time fell to just 18 days and continued the trend for the following months, alongside a 470% MoM increase in lead volume, accompanied by a 142% MoM surge in lead-to-close ratio.
- This transition, coinciding with the start of a new year, likely reflects a **planned marketing campaign or internal initiative**, rather than a gradual external market change.
- From **February 2018**, the lead-to-close ratio began a gradual **decline**.
  
![image](https://github.com/user-attachments/assets/868023d0-2bc7-42f8-bc08-93dd65225013)



### **Lead Sources Performance**

- Top lead sources by MQL volume, including **organic search, paid search, and social media**, together accounted for **over 50% of total MQLs.**
- Yet, efficiency-wise, **social media** performed poorly with only around a **5.6% lead-to-close ratio** and the longest conversion time among recognized sources **(30 days)**.
- In contrast, despite low MQL volume contribution (6.26%), up to **11.22% of direct traffic’s** leads transformed into closed deals with a median of **10 days** per lead, indicating untapped potential.
  
![image](https://github.com/user-attachments/assets/b1a18d23-0e25-46ec-a5ef-e7669992011d)


### **Business Types & Segments Performance**

- Overall, **resellers** accounted for **over 70% of all closed deals** while taking slightly **longer** (15 days) to convert than manufacturers (13 days).
- Home-related segments, including **household utilities and construction tools for the house and garden**, as well as **health and beauty products**, were prominent among the categories with **high deal closure counts** for both business types.
- However, **car accessories** were the leading segment for closed deals among resellers, while manufacturers mainly focused on **home decor.**
- **Low-volume segments **such as sports and leisure, bags and backpacks, and toys had the **shortest sales cycle** for resellers (6 days).
- For manufacturers, the segments with the quickest conversion times included pet products, car accessories, and health and beauty items, with a median of **7 days**. This suggests that these segments may have higher intent or simpler deal processes.
- Additionally, **home office furniture** consistently ranked among the top five segments with the fastest conversion times for both types of businesses.
  
![image](https://github.com/user-attachments/assets/904e903d-c291-4a90-9324-22d88d382de9)

## **Conclusions & Recommendations**

- The significant growth in volume and efficiency experienced in 2018 could be attributed to an internal revitalization, but it also coincided with the broader development of e-commerce at both the national level. This environment created opportunities for the company to attract more sellers to join its marketplace and offer their products, but also amplified competitiveness.
- Channels like **paid search and organic search** yielded high volumes and solid conversion, while **direct traffic** closed faster but contributed fewer leads. This suggests the need to **optimize the user experience of the company website**, such as streamlining the navigation and creating shareable content, to boost direct and organic traffic while reducing reliance on paid search.
- **Social media** was a significant source of MQLs; however, it struggles with a **slow** conversion duration and a **low** lead-to-close ratio. This discrepancy might stem from the existing sales processes or the characteristics of MQLs generated through this channel, indicating a need for **reassessment**. To enhance customer experience and shorten the sales cycle, the implementation of **advanced technologies**, such as chatbots, could be beneficial.
- Household utilities, gardening tools, and health and beauty products had numerous successful deals, while home office furniture converted fast for both resellers and manufacturers. At the same time, resellers and manufacturers primarily concentrated on car accessories and home decor, respectively. This presents an opportunity for **targeted advertising** and **direct connections** with businesses in these areas, such as offering its program by contacting home decor manufacturers directly.
- Some segments had **short sales cycles** but **low sales volume**. For resellers, categories like sports and leisure, bags and backpacks, and toys had the shortest sales cycles, while for manufacturers, they were pet products, car accessories, and health and beauty items. To boost closed deals, Olist can consider implementing **targeted promotions and offers** for fast-converting segments specific to each business type.

## **Caveats**
- Due to 8% closed deals with extreme conversion time, the decision was made to use the median rather than the average to reduce the influence of outliers.
  
![image](https://github.com/user-attachments/assets/ccefd7c5-0908-4d12-83fc-2848d48ac991)
- The **"unknown" lead source** accounted for almost 15% of lead volume and had the **highest conversion rate**, indicating possible **tracking inconsistencies**. Given the project’s scope, the decision was made to solely focus on the recognized sources. However, it was noted that this data ambiguity might skew the lead source's conclusions.
- The asymmetry in data between MQL and closed deals can introduce biases in insights.
- Segments with fewer than **10 closed deals** were excluded from conversion time analyses to ensure representativeness.
- Blank or unclassified categories were hidden in visualizations to focus insights on actionable segments.

## **Next Steps**

- Audit lead source tagging to resolve "Unknown" discrepancies.
- Investigate the deal size correlation with conversion time once revenue data becomes available to have a radical view on conversion efficiency.
- Dive deeper into outliers in conversion time to identify friction points or long-tail patterns in the customer journey.
- Investigate seasonality when data from the following years becomes available to determine if this MQL trend observed in the duration of 1 year is seasonal or reflects an unexpected change. 
