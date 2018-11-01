CREATE TABLE [dbo].[com_ListadoMateriales] (
    [IdEmpresa]           INT           NOT NULL,
    [IdListadoMateriales] NUMERIC (18)  NOT NULL,
    [CodObra]             VARCHAR (20)  NOT NULL,
    [ot_IdSucursal]       INT           NOT NULL,
    [IdOrdenTaller]       NUMERIC (18)  NULL,
    [FechaReg]            DATETIME      NOT NULL,
    [Estado]              CHAR (1)      NOT NULL,
    [Usuario]             VARCHAR (20)  NOT NULL,
    [Motivo]              VARCHAR (50)  NOT NULL,
    [lm_Observacion]      VARCHAR (500) NULL,
    CONSTRAINT [PK_com_ListadoMateriales] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdListadoMateriales] ASC),
    CONSTRAINT [FK_com_ListadoMateriales_com_ListadoMateriales] FOREIGN KEY ([IdEmpresa], [IdListadoMateriales]) REFERENCES [dbo].[com_ListadoMateriales] ([IdEmpresa], [IdListadoMateriales]),
    CONSTRAINT [FK_com_ListadoMateriales_com_ListadoMateriales1] FOREIGN KEY ([IdEmpresa], [IdListadoMateriales]) REFERENCES [dbo].[com_ListadoMateriales] ([IdEmpresa], [IdListadoMateriales])
);

