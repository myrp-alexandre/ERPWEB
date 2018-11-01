--exec spSys_GeneraDeclaracionColumnaCursor 'tbMG_Talme_Cliente'
CREATE procedure [dbo].[spSys_GeneraDeclaracionColumnaCursor]
@TableName varchar(100)
as
begin
    
	Declare @Acum nvarchar(max)
	declare @Parameter_name nvarchar(max)
	declare @NormalTables nvarchar(max)
	Declare @Acum2 nvarchar(max)
	set @Acum=''
	set @Acum2=''
	
	DECLARE cursor_clienteTalme CURSOR FOR 
                                 select 
			                     'Parameter_name'	= '@C_'+name+',',
			                     name+',' as NormalTables
                                 from sys.all_columns where object_id =  OBJECT_ID(@TableName)
    OPEN cursor_clienteTalme;
    FETCH NEXT FROM cursor_clienteTalme 
    INTO 
    @Parameter_name,@NormalTables
    WHILE @@FETCH_STATUS = 0
    BEGIN 
 
    set @Acum = @Acum+@Parameter_name 
	set @Acum2 = @Acum2+@NormalTables
 
      FETCH NEXT FROM cursor_clienteTalme 
        INTO @Parameter_name,@NormalTables
    END;

    CLOSE cursor_clienteTalme;
    DEALLOCATE cursor_clienteTalme;

      print substring(@Acum,0,len(@Acum)-1)
	 print substring(@Acum2,0,len(@Acum2)-1)
    end