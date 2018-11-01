CREATE TABLE [Grafinpren].[fa_notaCreDeb_graf] (
    [IdEmpresa]        INT           NOT NULL,
    [IdSucursal]       INT           NOT NULL,
    [IdBodega]         INT           NOT NULL,
    [IdNota]           NUMERIC (18)  NOT NULL,
    [num_op]           VARCHAR (500) NULL,
    [fecha_op]         DATE          NULL,
    [num_cotizacion]   VARCHAR (500) NULL,
    [fecha_cotizacion] DATE          NULL,
    [IdEquipo]         INT           NULL,
    [porc_comision]    FLOAT (53)    NULL,
    CONSTRAINT [PK_fa_notaCreDeb_graf] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdBodega] ASC, [IdNota] ASC),
    CONSTRAINT [FK_fa_notaCreDeb_graf_fa_notaCreDeb] FOREIGN KEY ([IdEmpresa], [IdSucursal], [IdBodega], [IdNota]) REFERENCES [dbo].[fa_notaCreDeb] ([IdEmpresa], [IdSucursal], [IdBodega], [IdNota])
);

