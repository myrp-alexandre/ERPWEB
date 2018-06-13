using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.General;
using Core.Erp.Data.General;
namespace Core.Erp.Bus.General
{
   public class tb_persona_tipo_Bus
    {
        tb_persona_tipo_Data data = new tb_persona_tipo_Data();

        public List<tb_persona_tipo_Info> get_list()
        {
            try
            {
                return data.get_list();
            }
            catch (Exception)
            {

                throw;
            }

        }
    }
    }
