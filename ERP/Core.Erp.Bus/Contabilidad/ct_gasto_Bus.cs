using Core.Erp.Data;
using Core.Erp.Data.Contabilidad;
using Core.Erp.Info.Contabilidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Contabilidad
{
    public class ct_gasto_Bus
    {
        ct_gasto_Data odata = new ct_gasto_Data();

        public List<ct_gasto_Info> GetList(bool MostrarAnulado)
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

        public ct_gasto_Info GetInfo(int IdGasto)
        {
            try
            {
                return odata.GetInfo(IdGasto);
            }
            catch (Exception)
            {
                throw;
            }
        }
        public ct_gasto_Info GetId(int IdEmpresa)
        {
            try
            {
                return odata.GetInfo(IdEmpresa);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool GuardarDB(ct_gasto_Info info)
        {
            try
            {
                return odata.GuardarDB(info);
            }
            catch (Exception)
            {
                throw;
            }
        }

        //public bool ModificarDB(ct_gasto_Info info)
        //{
        //    try
        //    {
        //        return odata.ModificarDB(info);
        //    }
        //    catch (Exception)
        //    {
        //        throw;
        //    }
        //}

        //public bool AnularDB(ct_gasto_Info info)
        //{
        //    try
        //    {
        //        return odata.AnularDB(info);
        //    }
        //    catch (Exception)
        //    {
        //        throw;
        //    }
        //}
    }
}
