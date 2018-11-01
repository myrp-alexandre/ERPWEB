CREATE TABLE [Fj_servindustrias].[fa_factura_fj] (
    [IdEmpresa]        INT           NOT NULL,
    [IdSucursal]       INT           NOT NULL,
    [IdBodega]         INT           NOT NULL,
    [IdCbteVta]        NUMERIC (18)  NOT NULL,
    [Atencion_a]       VARCHAR (500) NULL,
    [num_oc]           VARCHAR (50)  NULL,
    [descripcion_fact] VARCHAR (MAX) NULL,
    [fecha_cobro_1]    DATETIME      NULL,
    [fecha_cobro_2]    DATETIME      NULL,
    CONSTRAINT [PK_fa_factura_fj] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdBodega] ASC, [IdCbteVta] ASC),
    CONSTRAINT [FK_fa_factura_fj_fa_factura] FOREIGN KEY ([IdEmpresa], [IdSucursal], [IdBodega], [IdCbteVta]) REFERENCES [dbo].[fa_factura] ([IdEmpresa], [IdSucursal], [IdBodega], [IdCbteVta])
);

