using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Reportes.RRHH
{
   public class ROL_017_Info
    {
        public System.TimeSpan Entrada1 { get; set; }
        public System.TimeSpan Entrada2 { get; set; }
        public System.TimeSpan Salida1 { get; set; }
        public System.TimeSpan Salida2 { get; set; }
        public System.TimeSpan SalidaLounch { get; set; }
        public System.TimeSpan RegresoLounch { get; set; }
        public int IdEmpresa { get; set; }
        public decimal IdEmpleado { get; set; }
        public string pe_nombreCompleto { get; set; }
        public string pe_cedulaRuc { get; set; }
        public System.DateTime es_fechaRegistro { get; set; }
        public Nullable<System.TimeSpan> es_Hora { get; set; }
        public Nullable<int> es_anio { get; set; }
        public Nullable<int> es_mes { get; set; }
        public Nullable<int> es_semana { get; set; }
        public Nullable<int> es_dia { get; set; }
        public string es_sdia { get; set; }
        public string ma_descripcion { get; set; }
    }
}
