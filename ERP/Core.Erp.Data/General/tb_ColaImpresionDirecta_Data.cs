using Core.Erp.Info.General;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.General
{
    public class tb_ColaImpresionDirecta_Data
    {
        public bool guardarDB(tb_ColaImpresionDirecta_Info info)
        {
            try
            {
                using (Entities_general db = new Entities_general())
                {
                    db.tb_ColaImpresionDirecta.Add(new tb_ColaImpresionDirecta
                    {

                    });
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
