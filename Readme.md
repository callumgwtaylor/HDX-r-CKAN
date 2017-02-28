HDX-r-ckan
================
Callum G W Taylor
28 February 2017

-   [HDX](#hdx)
-   [Connecting to HDX](#connecting-to-hdx)
    -   [ckanr\_setup](#ckanr_setup)
-   [Structure](#structure)
    -   [Packages](#packages)
        -   [package\_list](#package_list)
        -   [package\_search](#package_search)
        -   [package\_show - to download HDX datasets](#package_show---to-download-hdx-datasets)
    -   [Tags](#tags)
        -   [tag\_list](#tag_list)
    -   [Groups](#groups)
        -   [group\_list](#group_list)
        -   [group\_show](#group_show)
            -   [variables in group](#variables-in-group)

HDX
---

This is an attempt to clarify how to access the Humanitarian Data Exchange and its datasets via R.

HDX is found at <http://data.humdata.org/>.

I've tried to use the ckanr package from ROpenSci, and packages from the tidyverse to display clean interpretable data

``` r
library(ckanr)
library(tidyverse)
```

Connecting to HDX
-----------------

### ckanr\_setup

ckan\_r setup will connect us to HDX

``` r
ckanr_setup(url = "http://data.humdata.org/")
```

Structure
---------

### Packages

#### package\_list

Each dataset on HDX is stored as a CKAN package

``` r
# package_list will show available packages, it usually has a limit of 31
all_packages <- package_list(as = 'table', limit = 5000)
all_packages <- as.data.frame(all_packages)
```

#### package\_search

``` r
# package_search can use text titles of the package for searching, it may provide more than one result
package_search_results <- package_search("migrant deaths by month")

# The structure of package search results is as follows
str(package_search_results, max.level = 1)
```

    ## List of 5
    ##  $ count        : int 3
    ##  $ sort         : chr "score desc, metadata_modified desc"
    ##  $ facets       : Named list()
    ##  $ results      :List of 3
    ##  $ search_facets: Named list()

``` r
# $count is an integer value of the number of results to that search
# $results is a list of the results from the search
```

``` r
str(package_search_results$results[[1]], max.level = 1)
```

    ## List of 38
    ##  $ data_update_frequency   : chr "1"
    ##  $ license_title           : chr "cc-by-igo"
    ##  $ maintainer              : chr "marindi"
    ##  $ relationships_as_object : list()
    ##  $ package_creator         : chr "marindi"
    ##  $ private                 : logi FALSE
    ##  $ dataset_date            : chr "02/21/2017"
    ##  $ num_tags                : int 4
    ##  $ solr_additions          : chr "{\"countries\": [\"World\"]}"
    ##  $ id                      : chr "c85c6e30-6b84-4076-b1a2-6433b65cbb09"
    ##  $ metadata_created        : chr "2015-12-22T20:59:59.171712"
    ##  $ methodology_other       : chr "http://missingmigrants.iom.int/methodology"
    ##  $ caveats                 : chr "Total figures include 331 deaths that are not included in the monthly breakdown because the month in which the deaths occured i"| __truncated__
    ##  $ metadata_modified       : chr "2017-02-27T09:01:58.439589"
    ##  $ author                  : chr ""
    ##  $ author_email            : chr ""
    ##  $ state                   : chr "active"
    ##  $ methodology             : chr "Other"
    ##  $ version                 : NULL
    ##  $ dataset_source          : chr "IOM"
    ##  $ license_id              : chr "cc-by-igo"
    ##  $ type                    : chr "dataset"
    ##  $ resources               :List of 3
    ##  $ num_resources           : int 3
    ##  $ tags                    :List of 4
    ##  $ tracking_summary        :List of 2
    ##  $ groups                  :List of 1
    ##  $ creator_user_id         : chr "23b4c749-bd1b-499c-a8f1-8d76240a534d"
    ##  $ maintainer_email        : chr ""
    ##  $ relationships_as_subject: list()
    ##  $ organization            :List of 11
    ##  $ name                    : chr "migrant-deaths-by-month"
    ##  $ isopen                  : logi FALSE
    ##  $ url                     : NULL
    ##  $ notes                   : chr "Missing Migrants Project draws on a range of sources to track deaths of migrants along migratory routes across the globe. Data "| __truncated__
    ##  $ owner_org               : chr "50dcc50c-84ee-4350-98fe-a9493b52742f"
    ##  $ title                   : chr "Migrant Deaths by month"
    ##  $ revision_id             : chr "c30dd0d8-fa44-4c2b-a0ee-c467acb546b2"
    ##  - attr(*, "class")= chr "ckan_package"

#### package\_show - to download HDX datasets

``` r
# package_show will download the selected package (OHDX dataset), when it has the id to use

# Gaining the dataset ID
first_search_result <- package_search_results$results[[1]] # This selects the first result from our search of datasets
dataset_title <- as.character(first_search_result$title) # This extracts the title so we can check we're on the right track
dataset_id <- as.character(first_search_result$id) # This extracts the id for that package
# Downloading the dataset itself
dataset <- package_show(first_search_result$id) # This will download the dataset
```

### Tags

#### tag\_list

Each tag is stored as a CKAN tag

``` r
# tag_list will show available tags
all_tags <- tag_list(as = 'table')
```

### Groups

#### group\_list

Each country on HDX is stored as a CKAN group

``` r
# group_list will show available CKAN groups. On HDX these mainly appear to be countries, however there are also some events such as the Nepal Earthquake.
all_groups <- group_list(as = 'table')
```

#### group\_show

``` r
#Each country on HDX has an id, you can get the id from the group_list

# group_show will download information about all packages related to the country specified
afghanistan <- group_show('afg', as = 'table') #afg is the id
```

##### variables in group

``` r
# For example:
afghanistan$display_name #Lists country name
```

    ## [1] "Afghanistan"

``` r
afghanistan$name #Country code for each group
```

    ## [1] "afg"

``` r
afghanistan$package_count #Lists amount of datasets associated
```

    ## [1] 171

``` r
# afghanistan$packages Countains info about all data sets

head(afghanistan$packages, n = 0) #this will show the list of variables when looking specifically the country's datasets
```

    ##  [1] owner_org                 maintainer               
    ##  [3] relationships_as_object   private                  
    ##  [5] dataset_date              num_tags                 
    ##  [7] solr_additions            id                       
    ##  [9] metadata_created          metadata_modified        
    ## [11] author                    author_email             
    ## [13] state                     relationships_as_subject 
    ## [15] methodology               version                  
    ## [17] dataset_source            license_id               
    ## [19] type                      maintainer_email         
    ## [21] num_resources             subnational              
    ## [23] title                     tracking_summary         
    ## [25] revision_id               creator_user_id          
    ## [27] methodology_other         package_creator          
    ## [29] name                      isopen                   
    ## [31] url                       notes                    
    ## [33] license_title             organization             
    ## [35] data_update_frequency     caveats                  
    ## [37] license_other             license_url              
    ## [39] indicator_type            indicator_type_code      
    ## [41] indicator                 more_info                
    ## [43] dataset_source_short_name last_data_update_date    
    ## [45] source_code               last_metadata_update_date
    ## [47] tags                     
    ## <0 rows> (or 0-length row.names)
