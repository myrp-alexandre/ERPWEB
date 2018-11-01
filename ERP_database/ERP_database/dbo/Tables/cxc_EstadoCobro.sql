CREATE TABLE [dbo].[cxc_EstadoCobro] (
    [IdEstadoCobro] VARCHAR (5)  NOT NULL,
    [Descripcion]   VARCHAR (50) NULL,
    [posicion]      INT          NULL,
    CONSTRAINT [PK_cxc_EstadoCobro] PRIMARY KEY CLUSTERED ([IdEstadoCobro] ASC)
);

