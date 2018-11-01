CREATE TABLE [dbo].[tb_rango_fecha_busqueda_x_periodo] (
    [Id]          INT          NOT NULL,
    [Descripcion] VARCHAR (50) NOT NULL,
    [valor_ini]   INT          NOT NULL,
    [valor_fin]   INT          NOT NULL,
    [uni_medida]  VARCHAR (20) NOT NULL,
    CONSTRAINT [PK_tb_rango_busqueda_x_periodo] PRIMARY KEY CLUSTERED ([Id] ASC)
);

