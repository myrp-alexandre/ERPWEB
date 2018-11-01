create view [dbo].[vwcp_Tipo_Impresion_Cheq]
as                      
select idcatalogo as Codigo,nombre as Descripcion
from cp_catalogo    
where idcatalogo_tipo='T_IMPR_RET'