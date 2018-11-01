 CREATE function calcular_dias_trabajados
 (@Fecha_inicio date,
  @Fecha_fin date,
  @fecha_ingreso date
 )
 returns int 
 as
 begin 
   declare @dias int
  set @dias= iif(@fecha_ingreso<=@Fecha_inicio,DATEDIFF(day ,@Fecha_inicio, @Fecha_fin)+1, DATEDIFF(day ,@fecha_ingreso, @Fecha_fin)+1)
     
   if(@dias>30)
   set @dias=30
   if((@dias=28 or @dias=29 and datepart(MONTH, @Fecha_inicio)=2) )
   set @dias=30

   return @dias
 end;