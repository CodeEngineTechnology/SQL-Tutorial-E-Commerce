use master
exec sp_adddistributor 
 @distributor = N'EC2AMAZ-RSMD1S4'
,@heartbeat_interval=10
,@password='Ecommerce1234!'

USE master
EXEC sp_adddistributiondb 
    @database = 'dist1', 
    @security_mode = 1;
GO

exec sp_adddistpublisher @publisher = N'EC2AMAZ-RSMD1S4', 
                         @distribution_db = N'dist1';
GO