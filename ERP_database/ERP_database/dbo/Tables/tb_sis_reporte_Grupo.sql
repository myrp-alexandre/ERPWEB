CREATE TABLE [dbo].[tb_sis_reporte_Grupo] (
    [IdGrupo_Reporte]   INT          NOT NULL,
    [Cod_Grupo_Reporte] VARCHAR (20) NOT NULL,
    [Descripcion]       VARCHAR (50) NOT NULL,
    [estado]            CHAR (1)     NOT NULL,
    CONSTRAINT [PK_tb_sis_Reporte_Grupos] PRIMARY KEY CLUSTERED ([IdGrupo_Reporte] ASC)
);

