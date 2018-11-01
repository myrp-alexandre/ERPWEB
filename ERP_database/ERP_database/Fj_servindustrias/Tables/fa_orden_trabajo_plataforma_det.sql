CREATE TABLE [Fj_servindustrias].[fa_orden_trabajo_plataforma_det] (
    [IdEmpresa]           INT            NOT NULL,
    [IdOrdenTrabajo_Pla]  NUMERIC (18)   NOT NULL,
    [secuencia]           INT            NOT NULL,
    [descrip_equipo_movi] VARCHAR (1500) NOT NULL,
    [punto_partida]       VARCHAR (1500) NOT NULL,
    [punto_llegada]       VARCHAR (1500) NOT NULL,
    [hora_ini]            TIME (7)       NULL,
    [hora_fin]            TIME (7)       NULL,
    [Valor]               FLOAT (53)     NOT NULL,
    CONSTRAINT [PK_fa_orden_trabajo_plataforma_det] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdOrdenTrabajo_Pla] ASC, [secuencia] ASC)
);

