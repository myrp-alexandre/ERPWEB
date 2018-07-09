using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Banco
{
    public class ba_Talonario_cheques_x_banco_Info
    {
        public int IdEmpresa { get; set; }
        public int IdBanco { get; set; }
        public string Num_cheque { get; set; }
        public Nullable<decimal> secuencia { get; set; }
        public bool Usado { get; set; }
        public string Estado { get; set; }
        public Nullable<int> IdEmpresa_cbtecble_Usado { get; set; }
        public Nullable<decimal> IdCbteCble_cbtecble_Usado { get; set; }
        public Nullable<int> IdTipoCbte_cbtecble_Usado { get; set; }
        public Nullable<System.DateTime> Fecha_uso { get; set; }
        public Nullable<System.DateTime> FechaAnulacion { get; set; }
        public string MotivoAnulacion { get; set; }
        public string IdUsuario_Anu { get; set; }

        // campos que no existen en la tabla

        public bool Estado_bool { get; set; }

    }
}
