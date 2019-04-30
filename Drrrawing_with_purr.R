# this code from https://fronkonstin.com/2019/03/27/drrrawing-with-purrr/

library(tidyverse)
library(ggplot2)

pentagon <- tibble(
  x    = accumulate(1:4, ~.x+cos(.y*2*pi/5), .init = 0),
  y    = accumulate(1:4, ~.x+sin(.y*2*pi/5), .init = 0),
  xend = accumulate(2:5, ~.x+cos(.y*2*pi/5), .init = cos(2*pi/5)),
  yend = accumulate(2:5, ~.x+sin(.y*2*pi/5), .init = sin(2*pi/5)))

ggplot(pentagon) +
  geom_segment(aes(x=x, y=y, xend=xend, yend=yend))+
  coord_equal()+
  theme_void()


polygon <- function(n) {
  tibble(
    x    = accumulate(1:(n-1), ~.x+cos(.y*2*pi/n), .init = 0),
    y    = accumulate(1:(n-1), ~.x+sin(.y*2*pi/n), .init = 0),
    xend = accumulate(2:n,     ~.x+cos(.y*2*pi/n), .init = cos(2*pi/n)),
    yend = accumulate(2:n,     ~.x+sin(.y*2*pi/n), .init = sin(2*pi/n)))
}

ggplot(polygon(6))+
  geom_segment(aes(x=x, y=y, xend=xend, yend=yend))+
  coord_equal()+
  theme_void()

ggplot(polygon(7))+
  geom_segment(aes(x=x, y=y, xend=xend, yend=yend))+
  coord_equal()+
  theme_void()

ggplot(polygon(8))+
  geom_segment(aes(x=x, y=y, xend=xend, yend=yend))+
  coord_equal()+
  theme_void()

ggplot(polygon(9))+
  geom_segment(aes(x=x, y=y, xend=xend, yend=yend))+
  coord_equal()+
  theme_void()



polygon(5) -> df1
df1 %>% mutate(angle = atan2(yend-y, xend-x)+pi/2,
               x = 0.5*x+0.5*xend,
               y = 0.5*y+0.5*yend,
               xend = x+0.2*cos(angle),
               yend = y+0.2*sin(angle)) %>% 
  select(x, y, xend, yend) -> df2
df1 %>% bind_rows(df2) -> df
ggplot(df)+
  geom_segment(aes(x=x, y=y, xend=xend, yend=yend))+
  coord_equal()+
  theme_void()


polygon(5) -> df1
df1 %>% mutate(angle = atan2(yend-y, xend-x)+pi/2,
               x = 0.5*x+0.5*xend,
               y = 0.5*y+0.5*yend,
               xend = x+0.2*cos(angle),
               yend = y+0.2*sin(angle)) %>% 
  select(x, y, xend, yend) -> df2
df2 %>% mutate(
  x=xend,
  y=yend,
  xend=lead(x, default=first(x)),
  yend=lead(y, default=first(y))) %>% 
  select(x, y, xend, yend) -> df3
df1 %>% bind_rows(df2) %>% bind_rows(df3) -> df
ggplot(df)+
  geom_segment(aes(x=x, y=y, xend=xend, yend=yend))+
  coord_equal()+
  theme_void()


mid_points <- function(d) {
  d %>% mutate(
    angle=atan2(yend-y, xend-x) + pi/2,
    x=0.5*x+0.5*xend,
    y=0.5*y+0.5*yend,
    xend=x+0.2*cos(angle),
    yend=y+0.2*sin(angle)) %>% 
    select(x, y, xend, yend)
}
con_points <- function(d) {
  d %>% mutate(
    x=xend,
    y=yend,
    xend=lead(x, default=first(x)),
    yend=lead(y, default=first(y))) %>% 
    select(x, y, xend, yend)
}
polygon(5) -> df1
df2 <- mid_points(df1)
df3 <- con_points(df2)
df4 <- mid_points(df3)
df5 <- con_points(df4)
df1 %>% 
  bind_rows(df2) %>% 
  bind_rows(df3) %>% 
  bind_rows(df4) %>% 
  bind_rows(df5) -> df
ggplot(df)+
  geom_segment(aes(x=x, y=y, xend=xend, yend=yend))+
  coord_equal()+
  theme_void()



edges <- 5
niter <- 4
polygon(edges) -> df1
accumulate(.f = function(old, y) {
  if (y%%2!=0) mid_points(old) else con_points(old)
},
1:niter,
.init=df1) %>% 
  bind_rows() -> df
ggplot(df)+
  geom_segment(aes(x=x, y=y, xend=xend, yend=yend))+
  coord_equal()+
  theme_void()


mid_points <- function(d, p) {
  d %>% mutate(
    angle=atan2(yend-y, xend-x) + pi/2,
    x=p*x+(1-p)*xend,
    y=p*y+(1-p)*yend,
    xend=x+0.2*cos(angle),
    yend=y+0.2*sin(angle)) %>% 
    select(x, y, xend, yend)
}
edges <- 7
niter <- 6
polygon(edges) -> df1
accumulate(.f = function(old, y) {
  if (y%%2==0) mid_points(old, 0.3) else con_points(old)
},
1:niter,
.init=df1) %>% 
  bind_rows() -> df
ggplot(df)+
  geom_segment(aes(x=x, y=y, xend=xend, yend=yend))+
  coord_equal()+
  theme_void()















