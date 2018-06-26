using System;

namespace Core.Erp.Info.Caja
{
    public class cp_conciliacion_Caja_det_x_ValeCaja_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdConciliacion_Caja { get; set; }
        public int Secuencia { get; set; }
        public int IdEmpresa_movcaja { get; set; }
        public decimal IdCbteCble_movcaja { get; set; }
        public int IdTipocbte_movcaja { get; set; }
        public string IdCtaCble { get; set; }
        public Nullable<int> IdPunto_cargo { get; set; }
        public Nullable<int> IdPunto_cargo_grupo { get; set; }
        public string IdCentroCosto { get; set; }
        public string IdCentroCosto_sub_centro_costo { get; set; }

        #region Campos que no existen en la tabla
        public DateTime fecha { get; set; }
        public double valor { get; set; }
        public int idTipoMovi { get; set; }
        public decimal IdPersona { get; set; }
        #endregion

    }
}
