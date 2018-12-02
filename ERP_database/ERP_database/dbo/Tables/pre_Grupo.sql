CREATE TABLE [dbo].[pre_Grupo] (
    [IdEmpresa]             INT           NOT NULL,
    [IdGrupo]               INT           NOT NULL,
    [Descripcion]           VARCHAR (MAX) NOT NULL,
    [Estado]                BIT           NOT NULL,
    [IdUsuarioCreacion]     VARCHAR (50)  NULL,
    [FechaCreacion]         DATETIME      NULL,
    [IdUsuarioModificacion] VARCHAR (50)  NULL,
    [FechaModificacion]     DATETIME      NULL,
    [IdUsuarioAnulacion]    VARCHAR (50)  NULL,
    [FechaAnulacion]        DATETIME      NULL,
    [MotivoAnulacion]       VARCHAR (MAX) NULL,
    CONSTRAINT [PK_pre_Grupo] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdGrupo] ASC)
);

