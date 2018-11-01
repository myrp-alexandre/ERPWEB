CREATE TABLE [dbo].[man_actividad] (
    [IdEmpresa]         INT           NOT NULL,
    [IdActividad]       NUMERIC (18)  NOT NULL,
    [ac_codigo]         VARCHAR (20)  NOT NULL,
    [ac_descripcion]    VARCHAR (500) NOT NULL,
    [ac_observacion]    VARCHAR (500) NULL,
    [ac_cant_horas_min] FLOAT (53)    NOT NULL,
    [estado]            BIT           NOT NULL,
    CONSTRAINT [PK_man_actividad] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdActividad] ASC)
);

