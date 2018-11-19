CREATE TABLE [dbo].[In_consignacion] (
    [IdEmpresa]             INT           NOT NULL,
    [IdConsignacion]        DECIMAL (18)  NOT NULL,
    [IdSucursal]            INT           NULL,
    [FechaConsignacion]     DATETIME      NULL,
    [IdProveedor]           DECIMAL (18)  NULL,
    [Observacion]           VARCHAR (MAX) NOT NULL,
    [Estado]                BIT           NULL,
    [IdUsuario]             VARCHAR (20)  NULL,
    [Fecha_Transac]         DATETIME      NULL,
    [IdUsuarioUltMod]       VARCHAR (20)  NULL,
    [Fecha_UltMod]          DATETIME      NULL,
    [IdUsuarioUltAnu]       VARCHAR (20)  NULL,
    [Fecha_UltAnu]          DATETIME      NULL,
    [IdEmpresa_ing]         INT           NOT NULL,
    [IdSucursal_ing]        INT           NOT NULL,
    [IdMovi_inven_tipo_ing] INT           NOT NULL,
    [IdNumMovi_ing]         NUMERIC (18)  NOT NULL,
    CONSTRAINT [PK_In_consignacion] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdConsignacion] ASC),
    CONSTRAINT [FK_In_consignacion_in_Ing_Egr_Inven] FOREIGN KEY ([IdEmpresa_ing], [IdSucursal_ing], [IdMovi_inven_tipo_ing], [IdNumMovi_ing]) REFERENCES [dbo].[in_Ing_Egr_Inven] ([IdEmpresa], [IdSucursal], [IdMovi_inven_tipo], [IdNumMovi]),
    CONSTRAINT [FK_In_consignacion_tb_empresa] FOREIGN KEY ([IdEmpresa]) REFERENCES [dbo].[tb_empresa] ([IdEmpresa])
);

