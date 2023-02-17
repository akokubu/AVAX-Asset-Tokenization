import DefaultLayout from '@/components/Layout/DefaultLayout'
import { NextPage } from 'next'
import HomeContainer from '@/components/Container/HomeContainer'

const Home: NextPage = () => {
  return (
    <DefaultLayout home>
      <HomeContainer />
    </DefaultLayout>
  )
}

export default Home;