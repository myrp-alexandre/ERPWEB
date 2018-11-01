CREATE TABLE [Fj_servindustrias].[fa_parametro_FJ] (
    [IdEmpresa]                          INT          NOT NULL,
    [p_tipo_porc_ganancia_tarifario_cat] VARCHAR (15) NULL,
    [p_IdProducto_prefacturacion]        DECIMAL (18) NULL,
    [p_IdCod_Impuesto_IVA]               VARCHAR (25) NULL,
    CONSTRAINT [PK_fa_parametro_FJ] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC),
    CONSTRAINT [FK_fa_parametro_FJ_fa_catalogo] FOREIGN KEY ([p_tipo_porc_ganancia_tarifario_cat]) REFERENCES [dbo].[fa_catalogo] ([IdCatalogo])
);

