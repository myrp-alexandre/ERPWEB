CREATE procedure [dbo].[spRo_Nomina_Tipoliqui_x_Sueldo](
@a int
)
as
begin
SELECT     A.IdEmpresa, A.IdNomina_Tipo, A.Descripcion, B.IdNomina_TipoLiqui, B.DescripcionProcesoNomina, ISNULL(C.PorSueldo, 0) AS Sueldo
,case  
when  C.IdEmpresa  IS null  then 'N'
else 'S'
end 
                      AS EstaEnBase
FROM         ro_Nomina_Tipo AS A INNER JOIN
                      ro_Nomina_Tipoliqui AS B ON A.IdNomina_Tipo = B.IdNomina_Tipo AND A.IdEmpresa = B.IdEmpresa LEFT OUTER JOIN
                      ro_Nomina_Tipoliqui_x_Sueldo AS C ON B.IdEmpresa = C.IdEmpresa AND B.IdNomina_Tipo = C.IdNomina_Tipo AND B.IdNomina_TipoLiqui = C.IdNomina_TipoLiqui
                      where a.IdEmpresa = @a
end