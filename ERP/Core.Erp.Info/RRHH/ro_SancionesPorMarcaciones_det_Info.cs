using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.RRHH
{
   public class ro_SancionesPorMarcaciones_det_Info
    {
        public int IdEmpresa { get; set; }
        public int IdAjuste { get; set; }
        public int Secuencia { get; set; }
        public int IdCalendario { get; set; }
        public decimal IdEmpleado { get; set; }
        public int IdSucursal { get; set; }
        public string IdTipoMarcaciones { get; set; }
        public System.TimeSpan EsHoraHorario { get; set; }
        public System.TimeSpan EsHoraMarcacion { get; set; }
        public double Minutos { get; set; }
        public decimal IdRegistro { get; set; }
        public string Observacion { get; set; }
        public System.DateTime es_fechaRegistro { get; set; }
        public string pe_nombreCompleto { get; set; }
        public string pe_apellido { get; set; }
        public string pe_nombre { get; set; }
        public string pe_cedulaRuc { get; set; }
        public string em_codigo { get; set; }


        #region campos vistas
        public System.TimeSpan time_entrada1 { get; set; }
        public System.TimeSpan time_salida1 { get; set; }
        public System.TimeSpan HoraIni { get; set; }
        public System.TimeSpan HoraFin { get; set; }
        #endregion
    }
}
