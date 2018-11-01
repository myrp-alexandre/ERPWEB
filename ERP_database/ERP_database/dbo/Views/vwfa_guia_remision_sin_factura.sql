CREATE view [dbo].[vwfa_guia_remision_sin_factura] as

select A.* 
from fa_guia_remision A
where cast(A.IdEmpresa as varchar(20))+ cast(A.Idsucursal as varchar(20))+cast(A.idbodega as varchar(20))
+ cast( A.IdGuiaRemision  as varchar(20)) not in
(  
select cast(gi_IdEmpresa as varchar(20)) + cast(gi_IdSucursal  as varchar(20))+ 
cast(gi_IdBodega as varchar(20))+  cast(gi_idguiaremision as varchar(20)) 
from  dbo.fa_factura_x_fa_guia_remision
)

--select * from vwfa_guia_remision_sin_factura