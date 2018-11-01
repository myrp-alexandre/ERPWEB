CREATE TABLE [dbo].[caj_Caja_Movimiento_Tipo_grupo] (
    [IdTipoMovi_grupo] INT           NOT NULL,
    [tg_descripcion]   VARCHAR (300) NOT NULL,
    [estado]           BIT           NOT NULL,
    CONSTRAINT [PK_caj_Caja_Movimiento_Tipo_grupo] PRIMARY KEY CLUSTERED ([IdTipoMovi_grupo] ASC)
);

