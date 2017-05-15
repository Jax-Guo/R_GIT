library(tidyr)
stocks <- data_frame(
    time = as.Date('2009-01-01') + 0:9,
    X = rnorm(10, 0, 1),
    Y = rnorm(10, 0, 2),
    Z = rnorm(10, 0, 4)
)

gather(stocks, stock, price, -time)
stocks %>% gather(stock, price, -time)



students2 %>%
    gather( sex_class,count ,-grade ) %>%
    separate( sex_class, c("sex", "class")) %>%
    print

students3 %>%
    gather(class, grade, class1:class5, na.rm = TRUE) %>%
    spread(test, grade) %>%
    mutate(class=parse_number(class)) %>%
    print

student_info <- students4 %>%
    select(id, name, sex) %>%
    unique() %>%
    print

gradebook <- students4 %>%
    select(id,class,midterm,final) %>%
    unique() %>%
    print

sat %>%
    select(-contains("total")) %>%
    gather(part_sex, count, -score_range) %>%
    separate(part_sex, c("part", "sex")) %>%
    group_by(part,sex) %>%
    mutate(total=sum(count),
           prop=count/total
    ) %>% print


