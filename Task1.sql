create user 'userGeodata2'@'localhost' identified by '12345';
grant all privileges on geodata.* to 'userGeodata2'@'localhost';
flush privileges;