# Call Centre Performance 
### Case brief

> A client wants an integrated tool to have a general overview of their Call Centre performance and make data-driven decisions such as detecting where the issues are and quickly fixing them.

###### 1. Understanding the business 
The client uses Microsoft products and has a system in place for data flow. The data is stored in an SQL database available to access offline and online as a relational database-as-a-service on Azure service.

###### 2. Understanding the data
The Call Centre data is stored in a separate table by Call Id and includes details by Agent, Date, Time, Topic, Answered status, Resolved status, Speed of answer in seconds, Average Talk Duration and Satisfaction rating.

###### 3. Define the solution
The most suitable for the case is to use the Microsoft Power BI product:
- The data is ready for use after minimal transformations;
- The staff is familiar with the Microsoft product and additional training is not required;
- The performance reports are always available and the access can be managed by the roles.

Agreed on KPIs with the client needed for the business to monitor:
- Overall customer satisfaction;
- Overall calls answered/abandoned;
- Calls by time;
- The average speed of answer;
- Agent’s performance (Count on answered calls and their duration);
- Filters by Month and Week.

###### 4. Data Preparation 
Connect the data source ***Power Query Editor***
a.	Promote the headers
```SQL
=Table.PromoteHeaders(Sheet1_Sheet, [PromoteAllScalars=true])
```
b.	Transform the data types
```SQL
=Table.TransformColumnTypes(#"Promoted Headers",{{"Call Id", type text}, {"Agent", type text}, {"Date", type date}, {"Time", type datetime}, {"Topic", type text}, {"Answered (Y/N)", type text}, {"Resolved", type text}, {"Speed of answer in seconds", Int64.Type}, {"AvgTalkDuration", type datetime}, {"Satisfaction rating", Int64.Type}})
```
c.	Split the date column by date and time
```SQL
=Table.SplitColumn(Table.TransformColumnTypes(#"Time", {{"Time - Copy", type text}}, "en-GB"), "Time - Copy", Splitter.SplitTextByEachDelimiter({" "}, QuoteStyle.Csv, false), {"Time - Copy.1", "Time - Copy.2"})
```
d.	Transform the data types for date and time
```SQL
=Table.TransformColumnTypes(#"Split Column by Delimiter",{{"Time - Copy.1", type date}, {"Time - Copy.2", type time}})
```

###### 5. Modelling
- [ ] Calls by hours KPI
- *Stacked column chart (Axis Y – Calls data, Axis X – count of Calls displayed in %)*
- [ ] Average speed of answers KPI
- *Gauge chart (Visual – Average value of Speed of answers data displayed in seconds)*
- [ ] Overall customer satisfaction KPI
- *Stacked column chart (Axis Y – Satisfaction rating data, Axis X – count of Satisfaction rating displayed in %)*
- [ ] Overall calls answered/abandoned KPI
- *Pie chart (Value – count of Answered calls data displayed in %)*
- [ ] Agent’s performance KPI
- *Multi-row card (Fields – Agent data, count of Answered calls data, average of Average Talk Duration data)*
- [ ] Filters by Month and Week
- *Slicer (Value – Date data grouped by months and weeks)*

###### 6. Evaluation 
The analysis of the model indicated a heathy performance as all queries were executed up to 0.6 seconds.




