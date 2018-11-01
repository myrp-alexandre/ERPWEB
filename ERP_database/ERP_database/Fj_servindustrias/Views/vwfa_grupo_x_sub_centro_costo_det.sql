CREATE VIEW [Fj_servindustrias].[vwfa_grupo_x_sub_centro_costo_det]
AS
SELECT         ct_centro_costo_sub_centro_costo.IdEmpresa, ct_centro_costo_sub_centro_costo.IdCentroCosto, 
                         ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo, ct_centro_costo_sub_centro_costo.cod_subcentroCosto, 
                         ct_centro_costo_sub_centro_costo.Centro_costo, ct_centro_costo_sub_centro_costo.pc_Estado, ct_centro_costo_sub_centro_costo.IdCtaCble, 
                         Fj_servindustrias.fa_grupo_x_sub_centro_costo_det.IdGrupo
FROM            Fj_servindustrias.fa_grupo_x_sub_centro_costo_det INNER JOIN
                         ct_centro_costo_sub_centro_costo ON Fj_servindustrias.fa_grupo_x_sub_centro_costo_det.IdEmpresa = ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         Fj_servindustrias.fa_grupo_x_sub_centro_costo_det.IdCentroCosto_sub_centro_costo = ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo AND 
                         Fj_servindustrias.fa_grupo_x_sub_centro_costo_det.IdCentroCosto = ct_centro_costo_sub_centro_costo.IdCentroCosto