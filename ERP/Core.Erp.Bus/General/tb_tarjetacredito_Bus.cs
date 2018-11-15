using Core.Erp.Data.General;
using Core.Erp.Info.General;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.General
{
    public class tb_TarjetaCredito_Bus
    {
        tb_TarjetaCredito_Data odata = new tb_TarjetaCredito_Data();

        public List<tb_TarjetaCredito_Info> GetList(bool MostrarAnulado)
        {
            try
            {
                return odata.GetList(MostrarAnulado);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool GuardarBD(tb_TarjetaCredito_Info info)
        {
            try
            {
                return odata.GuardarBD(info);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool ModificarBD(tb_TarjetaCredito_Info info)
        {
            try
            {
                return odata.ModificarBD(info);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool AnularBD(tb_TarjetaCredito_Info info)
        {
            try
            {
                return odata.AnularBD(info);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
        