CREATE TABLE [Grafinpren].[fa_factura_graf] (
    [IdEmpresa]        INT           NOT NULL,
    [IdSucursal]       INT           NOT NULL,
    [IdBodega]         INT           NOT NULL,
    [IdCbteVta]        NUMERIC (18)  NOT NULL,
    [num_op]           VARCHAR (500) NOT NULL,
    [fecha_op]         DATE          NOT NULL,
    [num_cotizacion]   VARCHAR (500) NOT NULL,
    [fecha_cotizacion] DATE          NOT NULL,
    [porc_comision]    FLOAT (53)    NOT NULL,
    [IdEquipo]         INT           NOT NULL,
    CONSTRAINT [PK_fa_factura_graf] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdBodega] ASC, [IdCbteVta] ASC),
    CONSTRAINT [FK_fa_factura_graf_fa_factura] FOREIGN KEY ([IdEmpresa], [IdSucursal], [IdBodega], [IdCbteVta]) REFERENCES [dbo].[fa_factura] ([IdEmpresa], [IdSucursal], [IdBodega], [IdCbteVta])
);

