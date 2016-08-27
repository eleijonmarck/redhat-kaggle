merge_and_write_data_to_disk <- function() {
    # Merges the activity and the people data by people_id and writes
    # the result to disc.
    
    # The function returns a string communicating the result.
    
    
    filename <- 'merged_data.csv'
    path <- '../data/processed/'
    fullname <- paste0(path, filename)
    if (file.exists(fullname)) {
        return (paste('File', fullname, 'already sourced.'))
    }
    
    activities_raw <- fread('../data/raw/act_train.csv')
    people_raw <- fread('../data/raw/people.csv')
    # Rename columns
    col_inds <- which(!colnames(activities_raw) %in% c('people_id', 'outcome',
                                                       'activity_id', 'activity_category'))
    for (ind in col_inds) {
        colname <- colnames(activities_raw)[ind]
        colnames(activities_raw)[ind] <- paste0('activity_', colname)
    } 
    
    col_inds <- which(!colnames(people_raw) %in% c('people_id'))
    for (ind in col_inds) {
        colname <- colnames(people_raw)[ind]
        colnames(people_raw)[ind] <- paste0('people_', colname)
    } 
    
    # Write merged data to disk
    merged_raw <- merge(x=people_raw, y=activities_raw, by='people_id')
    colnames(merged_raw)[which(colnames(merged_raw) == 'date.x')] <- 'people_date'
    colnames(merged_raw)[which(colnames(merged_raw) == 'date.y')] <- 'activity_date'
    write.csv(x=merged_raw, file=fullname)
    
    return (paste('File', fullname, 'written to disk'))
}
