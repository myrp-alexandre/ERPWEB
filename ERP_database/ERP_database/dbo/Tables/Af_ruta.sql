CREATE TABLE [dbo].[Af_ruta] (
    [IdEmpresa]      INT           NOT NULL,
    [IdRuta]         NUMERIC (18)  NOT NULL,
    [ru_descripcion] VARCHAR (500) NOT NULL,
    [ru_cantidad_km] FLOAT (53)    NOT NULL,
    [ru_observacion] VARCHAR (100) NULL,
    [estado]         BIT           NOT NULL,
    CONSTRAINT [PK_Af_ruta] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdRuta] ASC)
);

