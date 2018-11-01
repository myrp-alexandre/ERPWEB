CREATE TABLE [dbo].[tbBAN_Rpt007] (
    [IdEmpresa]         INT           NOT NULL,
    [idTipoFlujo]       NUMERIC (18)  NULL,
    [descripcion_flujo] VARCHAR (200) NULL,
    [observacion]       VARCHAR (200) NULL,
    [fecha]             DATETIME      NULL,
    [Des_tipo_cbte]     VARCHAR (100) NULL,
    [IdCbte]            NUMERIC (18)  NULL,
    [dc_Valor]          FLOAT (53)    NULL,
    [ba_descripcion]    VARCHAR (100) NULL,
    [tipo]              VARCHAR (50)  NULL,
    [ba_Num_Cuenta]     VARCHAR (100) NULL,
    [Orden]             INT           NULL
);

