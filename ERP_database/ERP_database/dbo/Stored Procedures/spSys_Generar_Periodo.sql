--exec dbo.spSys_GeneraDeclaracionColumnaCursor 'ct_periodo'

-- spSys_Generar_Periodo 3
CREATE proc [dbo].[spSys_Generar_Periodo]
(
@idempresa int
)
as
begin
/*
declare @idempresa int
set @idempresa=1
*/


declare @idaniofiscal int 
declare @C_countMes int

declare @w_fechaIni varchar(20)
declare @w_fechaFin varchar(20)





delete ct_periodo where IdEmpresa =@idempresa


    DECLARE product_cursor CURSOR FOR 
		select idaniofiscal
		from ct_anio_fiscal
    OPEN product_cursor;
    FETCH NEXT FROM product_cursor 
    INTO @idaniofiscal
    

    WHILE @@FETCH_STATUS = 0
    BEGIN
		
		set @C_countMes=1
		
		while (@C_countMes<=12)
		begin
			
				set @w_fechaIni=cast(@C_countMes as varchar(2)) + '/' +'01/' +cast(@idaniofiscal as varchar(4))
				set @w_fechaFin=dateadd( month,1,@w_fechaIni) -1  
							
				INSERT INTO ct_periodo
				( IdEmpresa		, IdPeriodo		, IdanioFiscal	, pe_mes
				, pe_FechaIni	, pe_FechaFin	, pe_cerrado	, pe_estado
				)
				values
				(
				@idempresa		,(@idaniofiscal*100)+@C_countMes  ,@idaniofiscal	,@C_countMes
				,@w_fechaIni	,@w_fechaFin	,'N'			,'A'
				)
				
			set @C_countMes=@C_countMes+1	
		
		end 
        
			


print @idaniofiscal

        
        FETCH NEXT FROM product_cursor 
        INTO @idaniofiscal
        
    END;

    CLOSE product_cursor;
    DEALLOCATE product_cursor;
    



select * from ct_periodo

end