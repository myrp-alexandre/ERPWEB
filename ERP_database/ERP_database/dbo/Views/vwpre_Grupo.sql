create view vwpre_Grupo as
SELECT        dbo.pre_Grupo.IdEmpresa, dbo.pre_Grupo.IdGrupo, dbo.pre_Grupo.Descripcion, dbo.pre_Grupo.Estado, dbo.pre_Grupo_x_seg_usuario.Secuencia, dbo.pre_Grupo_x_seg_usuario.IdUsuario, 
                         dbo.pre_Grupo_x_seg_usuario.AsignaCuentas, dbo.seg_usuario.Nombre
FROM            dbo.pre_Grupo INNER JOIN
                         dbo.pre_Grupo_x_seg_usuario ON dbo.pre_Grupo.IdEmpresa = dbo.pre_Grupo_x_seg_usuario.IdEmpresa AND dbo.pre_Grupo.IdGrupo = dbo.pre_Grupo_x_seg_usuario.IdGrupo INNER JOIN
                         dbo.seg_usuario ON dbo.pre_Grupo_x_seg_usuario.IdUsuario = dbo.seg_usuario.IdUsuario