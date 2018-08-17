using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.RRHH
{
   public class ro_rol_detalle_Info
    {
        public int IdEmpresa { get; set; }
        public int IdNominaTipo { get; set; }
        public int IdNominaTipoLiqui { get; set; }
        public int IdPeriodo { get; set; }
        public decimal IdEmpleado { get; set; }
        public string IdRubro { get; set; }
        public int Orden { get; set; }
        public double Valor { get; set; }
        public Nullable<bool> rub_visible_reporte { get; set; }
        public string Observacion { get; set; }
        public string TipoMovimiento { get; set; }
        public string IdCentroCosto { get; set; }
        public string IdCentroCosto_sub_centro_costo { get; set; }
        public Nullable<int> IdPunto_cargo { get; set; }

        public Nullable<int> IdArea { get; set; }
        public Nullable<int> IdDivision { get; set; }
        public int IdDepartamento { get; set; }
        public Nullable<int> IdCargo { get; set; }

        public decimal IdPersona { get; set; }
        public decimal IdEntidad { get; set; }
        public System.DateTime pe_FechaFin { get; set; }
        public string pe_nombreCompleato { get; set; }
        public string ru_tipo { get; set; }



    }
}
