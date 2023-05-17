# laravel-docker


alter user 'username'@'localhost' identified with mysql_native_password by 
'password';



go to sudo nano app/Providers/AppServiceProvider.php
add this condition to boot() function

\URL::forceScheme('https');
