CREATE TABLE [dbo].[Af_spACTF_Rpt012] (
    [IdEmpresa]              INT           NOT NULL,
    [IdActivoFijo]           INT           NOT NULL,
    [IdUsuario]              VARCHAR (20)  NOT NULL,
    [IdSucursal]             INT           NOT NULL,
    [Su_Descripcion]         VARCHAR (100) NOT NULL,
    [CodActivoFijo]          VARCHAR (50)  NOT NULL,
    [Af_Nombre]              VARCHAR (500) NOT NULL,
    [IdActivoFijoTipo]       INT           NOT NULL,
    [tipo_AF]                VARCHAR (200) NOT NULL,
    [IdCategoria_Af]         INT           NOT NULL,
    [Categoria_AF]           VARCHAR (200) NOT NULL,
    [Af_costo_compra]        FLOAT (53)    NOT NULL,
    [Af_Depreciacion_acum]   FLOAT (53)    NOT NULL,
    [Costo_actual]           FLOAT (53)    NOT NULL,
    [valor_ult_depreciacion] FLOAT (53)    NOT NULL,
    [Af_fecha_compra]        DATETIME      NOT NULL,
    CONSTRAINT [PK_Af_spACTF_Rpt012] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdActivoFijo] ASC, [IdUsuario] ASC)
);

