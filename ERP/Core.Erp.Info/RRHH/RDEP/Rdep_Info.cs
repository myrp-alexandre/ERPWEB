using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.RRHH.RDEP
{
   public class Rdep_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdEmpleado { get; set; }
        public Nullable<int> pe_anio { get; set; }
        public string Su_CodigoEstablecimiento { get; set; }
        public string pe_cedulaRuc { get; set; }
        public string pe_nombre { get; set; }
        public string pe_apellido { get; set; }
        public Nullable<double> Sueldo { get; set; }
        public Nullable<decimal> FondosReserva { get; set; }
        public Nullable<decimal> DecimoTercerSueldo { get; set; }
        public Nullable<double> DecimoCuartoSueldo { get; set; }
        public Nullable<decimal> Vacaciones { get; set; }
        public Nullable<double> AportePErsonal { get; set; }
        public double GastoAlimentacion { get; set; }
        public double GastoEucacion { get; set; }
        public double GastoSalud { get; set; }
        public double GastoVestimenta { get; set; }
        public double GastoVivienda { get; set; }
        public double Utilidades { get; set; }
        public Nullable<double> IngresoVarios { get; set; }
    }
}
