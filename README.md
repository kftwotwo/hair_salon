# Hair Salon

A manger can look at this and view clients and Stylist, 2016-12-9

By [Kevin Finley](http://www.kfinley.com)

## Description

You can add or delete or edit stylists and clients and enter first and last name so no one gets confused!

## Setup/Installation Requirements

Clone the repository and `cd` into your directory :
```
$ bundle install
```
Now enter the following psql commands:
```
# CREATE DATABASE hair_salon;
# \c hair_salon;
# CREATE TABLE clients (id serial primary key, first_name varchar, last_name varchar, stylist_id);
# CREATE TABLE stylists (id serial primary key,first_name varchar, last_name varchar);
# CREATE DATABASE hair_salon_test with template library_test
```

## Known Bugs

If you notice any bugs or problems you can fill out an issue [here](https://www.github.com/kftwotwo/hair_salon/issue) or feel free to do a pull request [here](https://www.github.com/kftwotwo/{project}/pulls)!

## Contact details
Here is my email kf.two.two@gmail.com

## Contribute

Issue Tracker: https://github.com/kftwotwo/hair_salon/issues

Pull Request: https://github.com/kftwotwo/{project}/pulls

Source Code: https://github.com/kftwotwo/hair_salon


## Technologies Used
```
HTML
CSS
Ruby
Postgres
```
### License

*This is under a MIT License*

Copyright (c) 2016 **_Kevin Finley_**
