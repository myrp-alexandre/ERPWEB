CREATE TABLE [dbo].[in_recepcion_material_cab] (
    [IdEmpresa]           INT           NOT NULL,
    [IdSucursal]          INT           NOT NULL,
    [IdRecepcionMaterial] NUMERIC (18)  NOT NULL,
    [IdOrdenCompra]       NUMERIC (18)  NOT NULL,
    [NumRecepcion]        VARCHAR (50)  NOT NULL,
    [Fecha]               DATETIME      NOT NULL,
    [Estado]              CHAR (1)      NOT NULL,
    [EstadoRecepcion]     CHAR (1)      NOT NULL,
    [Observacion]         VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_in_recepcion_material_cab] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdRecepcionMaterial] ASC, [IdOrdenCompra] ASC),
    CONSTRAINT [FK_in_recepcion_material_cab_tb_sucursal] FOREIGN KEY ([IdEmpresa], [IdSucursal]) REFERENCES [dbo].[tb_sucursal] ([IdEmpresa], [IdSucursal])
);

