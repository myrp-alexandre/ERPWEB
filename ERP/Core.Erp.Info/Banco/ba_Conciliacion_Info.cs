using System;

namespace Core.Erp.Info.Banco
{
    public class ba_Conciliacion_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdConciliacion { get; set; }
        public int IdBanco { get; set; }
        public int IdPeriodo { get; set; }
        public System.DateTime co_Fecha { get; set; }
        public string IdEstado_Concil_Cat { get; set; }
        public double co_SaldoContable_MesAnt { get; set; }
        public double co_totalIng { get; set; }
        public double co_totalEgr { get; set; }
        public double co_SaldoContable_MesAct { get; set; }
        public double co_SaldoBanco_EstCta { get; set; }
        public double co_SaldoBanco_anterior { get; set; }
        public string Estado { get; set; }
        public string IdUsuario { get; set; }
        public string IdUsuario_Anu { get; set; }
        public string IdUsuarioUltMod { get; set; }
        public Nullable<System.DateTime> Fecha_Transac { get; set; }
        public Nullable<System.DateTime> Fecha_UltMod { get; set; }
        public Nullable<System.DateTime> FechaAnulacion { get; set; }
        public string MotivoAnulacion { get; set; }
        public string co_Observacion { get; set; }

        #region Campos que no existen en la tabla
        public string Periodo { get; set; }
        public string IdCtaCble { get; set; }
        public string ba_descripcion { get; set; }
        #endregion

    }
}
