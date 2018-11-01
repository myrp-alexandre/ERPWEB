CREATE VIEW [Fj_servindustrias].[vwfa_grupo_x_sub_centro_costo_det_scc_sin_grupo]
AS
SELECT        IdEmpresa, IdCentroCosto, IdCentroCosto_sub_centro_costo, cod_subcentroCosto, Centro_costo, pc_Estado, IdCtaCble
FROM            ct_centro_costo_sub_centro_costo 
WHERE  IdCentroCosto_sub_centro_costo NOT IN 
(
SELECT        ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo
FROM            ct_centro_costo_sub_centro_costo INNER JOIN
                         Fj_servindustrias.fa_grupo_x_sub_centro_costo_det ON 
                         ct_centro_costo_sub_centro_costo.IdEmpresa = Fj_servindustrias.fa_grupo_x_sub_centro_costo_det.IdEmpresa AND 
                         ct_centro_costo_sub_centro_costo.IdCentroCosto = Fj_servindustrias.fa_grupo_x_sub_centro_costo_det.IdCentroCosto AND 
                         ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo = Fj_servindustrias.fa_grupo_x_sub_centro_costo_det.IdCentroCosto_sub_centro_costo INNER JOIN
                         Fj_servindustrias.fa_grupo_x_sub_centro_costo ON 
                         Fj_servindustrias.fa_grupo_x_sub_centro_costo_det.IdEmpresa = Fj_servindustrias.fa_grupo_x_sub_centro_costo.IdEmpresa AND 
                         Fj_servindustrias.fa_grupo_x_sub_centro_costo_det.IdGrupo = Fj_servindustrias.fa_grupo_x_sub_centro_costo.IdGrupo AND
						 Fj_servindustrias.fa_grupo_x_sub_centro_costo.Estado = 1
)