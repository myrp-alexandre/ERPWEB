using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Importacion
{
   public class imp_partida_arancelaria_Info
    {
        public decimal IdArancel { get; set; }
        public string CodigoPartidaArancelaria { get; set; }
        public string Descripcion { get; set; }
        public decimal TarifaArancelaria { get; set; }
        public string Observacion { get; set; }
        public bool Estado { get; set; }
    }
}
