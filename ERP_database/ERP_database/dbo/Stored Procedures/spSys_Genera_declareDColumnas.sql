
create procedure [dbo].[spSys_Genera_declareDColumnas] 
@NombreTabla varchar(50)
as
begin 								 
							
                                 select 'declare ',
			                     'Parameter_name'	= '@C_'+name, 
			                     'Type'				= type_name(user_type_id), 
			                     'Length'			=  '('+Convert(varchar(50),max_length)+')'
                                 from sys.all_columns where object_id =  OBJECT_ID(@NombreTabla)
                                 
end