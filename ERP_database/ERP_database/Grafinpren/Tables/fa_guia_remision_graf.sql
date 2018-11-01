CREATE TABLE [Grafinpren].[fa_guia_remision_graf] (
    [IdEmpresa]        INT           NOT NULL,
    [IdSucursal]       INT           NOT NULL,
    [IdBodega]         INT           NOT NULL,
    [IdGuiaRemision]   NUMERIC (18)  NOT NULL,
    [Num_OP]           VARCHAR (500) NOT NULL,
    [Num_Cotizacion]   NUMERIC (18)  NULL,
    [fecha_Cotizacion] DATETIME      NULL,
    [IdEquipo]         INT           NOT NULL,
    CONSTRAINT [PK_fa_guia_remision_graf] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdBodega] ASC, [IdGuiaRemision] ASC)
);

