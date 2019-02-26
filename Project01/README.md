# Project 1
Bash and Git
# Features!
The following contains
  - 5.0 Stock Quote Fetcher (custom feature), fetches real time data on price, date, open, high, low, close,
volume and much more on American listed stocks
  - 5.2 Create a TODO Log, finds line of every file with the tag #TODO and records it into todo.log
  - 5.3 For all python and haskell files, records all compile errors
  - 5.5 File Type Count, outputs the count of all HTML, JavaScript, CSS, Python, Haskell and Bash Script files
### Usage
SSH into the mac1xa3 server

``` $ cd home/patea80/CS1XA3/Project01```

``` $ ./project_analyze.sh ```

The script will prompt you to select the following options,

``` Press 0 to exit ``` 

``` Press 5.0 to run script Stock Quote Fetcher ```

``` Press 5.2 to run script Create a TODO Log ```

``` Press 5.3 to run script Compile Error ```

``` Press 5.5 to run script File Type Count ```

Enter the corresponding number to run the desired script
### 5.0 Stock Quote Fetcher
After entering '5.0' as prompted,

``` Running script 5.0 Stock Quote Fetcher... ```

``` Enter stock ticker to find real time information on stock or enter 0 to exit back to the menu ``` 

Enter an American listed stock (NASDAQ, NYSE), for example 'msft' represents Microsoft Corporation 

``` >msft ``` 

```
1 Month information on msft:
date,open,high,low,close,volume,unadjustedVolume,change,changePercent,vwap,label,changeOverTime
2019-01-24,106.4055,106.5449,104.892,105.7483,23164838,23164838,-0.507831,-0.478,105.5886,Jan 24,0 ...
2019-02-22,110.05,111.2,109.82,110.97,27763218,27763218,1.56,1.426,110.7459,Feb 22,0.04937857157041767  
```

 ``` Current msft stock price: Sun Feb 24 06:43:13 UTC 2019 110.97 ``` 

 ``` To exit back to the menu, enter 0 when prompted ```

API reference: https://iextrading.com, https://www.marketwatch.com

### 5.2 TODO Log
After entering '5.2' as prompted,

``` Running script 5.2 Create a TODO Log... ```

``` Done. ```

you can view output of all #TODO lines by,

``` $ cat todo.log ```

  ### 5.2 Complile Error Log
After entering '5.3' as prompted,

``` Running script 5.3 Compile Error Log...```

``` Done. ```

you can view output of all compile errors by,

``` $ cat compile_fail.log ```

``` Done. ```

### 5.5 File Type Count
After entering '5.5' as prompted, the file count should be displayed, something like this

``` Running script 5.5 File Type Count in CS1XA3 directory... ```

``` HTML: 1 , JavaScript: 0, Python: 2, Haskell: 0, Bashscript: 1 ```

``` Done. ```

